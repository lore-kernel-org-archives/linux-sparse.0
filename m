From: Dave Jones <davej@redhat.com>
Subject: assertion when running sparse on current linux.git
Date: Wed, 7 Nov 2007 12:58:47 -0500
Message-ID: <20071107175847.GA19586@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48459 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755084AbXKGR6t (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Nov 2007 12:58:49 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA7Hwnj4007060
	for <linux-sparse@vger.kernel.org>; Wed, 7 Nov 2007 12:58:49 -0500
Received: from gelk.kernelslacker.org (vpn-14-5.rdu.redhat.com [10.11.14.5])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA7Hwm6r022270
	for <linux-sparse@vger.kernel.org>; Wed, 7 Nov 2007 12:58:48 -0500
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.14.1/8.13.8) with ESMTP id lA7HwmgH019921
	for <linux-sparse@vger.kernel.org>; Wed, 7 Nov 2007 12:58:48 -0500
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.14.1/8.14.1/Submit) id lA7HwlZC019920
	for linux-sparse@vger.kernel.org; Wed, 7 Nov 2007 12:58:47 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

$ make kernel/sched.o C=1
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHECK   kernel/sched.c
kernel/sched_idletask.c:69:26: warning: symbol 'idle_sched_class' was not declared. Should it be static?
kernel/sched_rt.c:239:26: warning: symbol 'rt_sched_class' was not declared. Should it be static?
kernel/sched.c:1885:17: warning: symbol 'schedule_tail' was not declared. Should it be static?
kernel/sched.c:3616:15: warning: incorrect type in assignment (different signedness)
kernel/sched.c:3616:15:    expected long *switch_count
kernel/sched.c:3616:15:    got unsigned long *<noident>
kernel/sched.c:3638:16: warning: incorrect type in assignment (different signedness)
kernel/sched.c:3638:16:    expected long *switch_count
kernel/sched.c:3638:16:    got unsigned long *<noident>
kernel/sched.c:5624:12: warning: symbol 'migration_init' was not declared. Should it be static?
kernel/sched.c:5841:25: error: cannot size expression
sparse: flow.c:805: rewrite_parent_branch: Assertion `changed' failed.
/bin/sh: line 1: 19800 Aborted                 sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__x86_64__ -m64 -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.1.2/include -Wp,-MD,kernel/.sched.o.d -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.1.2/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -mtune=generic -m64 -mno-red-zone -mcmodel=kernel -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -fstack-protector -fomit-frame-pointer -g -fno-stack-protector -Wdeclaration-after-statement
  -Wno-pointer-sign -fno-omit-frame-pointer -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(sched)" -D"KBUILD_MODNAME=KBUILD_STR(sched)" kernel/sched.c
make[1]: *** [kernel/sched.o] Error 134
make: *** [kernel/sched.o] Error 2



	Dave

-- 
http://www.codemonkey.org.uk
