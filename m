From: Jim Cromie <jim.cromie@gmail.com>
Subject: sparse problems with __acquires, __releases
Date: Sun, 7 Aug 2011 21:48:30 -0600
Message-ID: <CAJfuBxzGFiFj-bZ7J6aqffMXaxy33mhs0r3nvbFfRS8TBj_8XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:44081 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab1HHDtA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Aug 2011 23:49:00 -0400
Received: by pzk37 with SMTP id 37so7596709pzk.1
        for <linux-sparse@vger.kernel.org>; Sun, 07 Aug 2011 20:49:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

hi all,

after trying to use  __acquires, __releases in lib/dynamic_debug.c
I get the following warning.

[jimc@harpo linux-2.6]$ make C=1 lib/dynamic_debug.o
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHECK   lib/dynamic_debug.c
lib/dynamic_debug.c:548:13: warning: context imbalance in
'ddebug_proc_start' - wrong count at exit
lib/dynamic_debug.c:629:13: warning: context imbalance in
'ddebug_proc_stop' - wrong count at exit
  CC      lib/dynamic_debug.o

Thinking I did it wrong, I tried C=1 on other uses in the source..
The closest usage to mine (that I found) is in drivers/tty/tty_io.c:

void tty_write_unlock(struct tty_struct *tty)
	__releases(&tty->atomic_write_lock)
{
	mutex_unlock(&tty->atomic_write_lock);
	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
}

int tty_write_lock(struct tty_struct *tty, int ndelay)
	__acquires(&tty->atomic_write_lock)
{...}

it also gives errors, like mine.

[jimc@harpo linux-2.6]$ make C=1 drivers/tty/tty_io.o
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHECK   drivers/tty/tty_io.c
drivers/tty/tty_io.c:217:6: warning: symbol 'tty_del_file' was not
declared. Should it be static?
drivers/tty/tty_io.c:536:6: warning: symbol '__tty_hangup' was not
declared. Should it be static?
drivers/tty/tty_io.c:964:6: warning: context imbalance in
'tty_write_unlock' - wrong count at exit
drivers/tty/tty_io.c:971:5: warning: context imbalance in
'tty_write_lock' - wrong count at exit
drivers/tty/tty_io.c:1093:17: warning: context imbalance in
'tty_write_message' - unexpected unlock
drivers/tty/tty_io.c:1115:16: warning: context imbalance in
'tty_write' - different lock contexts for basic block
drivers/tty/tty_io.c:2429:12: warning: context imbalance in
'send_break' - different lock contexts for basic block
  CC      drivers/tty/tty_io.o

Heres my usage:

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 75ca78f..a2f82f2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -546,6 +546,7 @@ static struct _ddebug *ddebug_iter_next(struct
ddebug_iter *iter)
  * seeks the seq_file's iterator to the given position.
  */
 static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
+       __acquires(ddebug_lock)
 {
        struct ddebug_iter *iter = m->private;
        struct _ddebug *dp;
@@ -626,6 +627,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
  * call from userspace.  Drops ddebug_lock.
  */
 static void ddebug_proc_stop(struct seq_file *m, void *p)
+       __releases(ddebug_lock)
 {
        if (verbose)
                printk(KERN_INFO "%s: called m=%p p=%p\n",
