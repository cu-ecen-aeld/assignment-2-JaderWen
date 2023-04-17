#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <syslog.h>
#include <stddef.h>
#include <stdbool.h>
#include <string.h>

#define dbg_log(level, fmt, args...)      \
do {      \
  static bool once;     \
  if(!once){     \
	  openlog(NULL, LOG_NDELAY|LOG_NOWAIT|LOG_PID, LOG_USER);      \
    once = true;      \
  }     \
	syslog(level, fmt, ##args);     \
} while (0)

int writer(const char *writefile, const char *writestr){
  int ret = 0;
  int fd = open(writefile, O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
  if(fd < 0){
    dbg_log(LOG_ERR, "%s cannot be created or replaced", writefile);
    return -1;
  }

  ret = write(fd, (void *)writestr, strlen(writestr));
  if(ret < 0){
    dbg_log(LOG_ERR, "Cannot write %s into %s.", writestr, writefile);
  }
  else{
    dbg_log(LOG_DEBUG, "Writing \"%s\" to %s", writestr, writefile);
  }

  close(fd);
  return ret;
}

int main(int argc, char *argv[]){
  if(argc != 3){
    dbg_log(LOG_ERR, "Please pass exactly 2 arguments.");
    return 1;
  }

  char *path = argv[1], *str = argv[2];

  if(!str || !str[0]){
    dbg_log(LOG_ERR, "Written string \"%s\" is invalid.", str);
    return 1;
  }

  if(writer(path, str) < 0)
    return 1;

  return 0;
}
