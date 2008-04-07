From: Jiri Slaby <jirislaby@gmail.com>
Subject: rewrite_parent_branch: Assertion `changed' failed
Date: Mon, 07 Apr 2008 20:53:35 +0200
Message-ID: <47FA6DAF.3030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:27960 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbYDGSxo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Apr 2008 14:53:44 -0400
Received: by yw-out-2324.google.com with SMTP id 5so257322ywb.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Apr 2008 11:53:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I got this from sparse:
  CHECK   /home/l/latest/xxx/net/mac80211/ieee80211.c
sparse: flow.c:804: rewrite_parent_branch: Assertion `changed' failed.
/bin/sh: line 1:  8639 Ne=C3=BAsp=C4=9B=C5=A1n=C4=9B ukon=C4=8Den (SIGA=
BRT)        sparse -D__linux__=20
-Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__x86_64__ -m64 -nostd=
inc=20
-isystem /usr/lib64/gcc/x86_64-suse-linux/4.2.1/include=20
-Wp,-MD,net/mac80211/.ieee80211.o.d -nostdinc -isystem=20
/usr/lib64/gcc/x86_64-suse-linux/4.2.1/include -D__KERNEL__ -Iinclude -=
Iinclude2=20
-I/home/l/latest/xxx/include -include include/linux/autoconf.h=20
-I/home/l/latest/xxx/net/mac80211 -Inet/mac80211 -Wall -Wundef=20
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common=20
-Werror-implicit-function-declaration -O2 -fno-stack-protector -m64=20
-mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -funit-at-a-time=20
-maccumulate-outgoing-args -DCONFIG_AS_CFI=3D1 -DCONFIG_AS_CFI_SIGNAL_F=
RAME=3D1=20
-pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-m=
mx=20
-mno-sse2 -mno-3dnow -fno-omit-frame-pointer -fno-optimize-sibling-call=
s -g=20
-Wdeclaration-after-statement -Wno-pointer-sign -DMODULE -D"KBUILD_STR(=
s)=3D#s"=20
-D"KBUILD_BASENAME=3DKBUILD_STR(ieee80211)"=20
-D"KBUILD_MODNAME=3DKBUILD_STR(mac80211)" /home/l/latest/xxx/net/mac802=
11/ieee80211.c
make[3]: *** [net/mac80211/ieee80211.o] Error 134
make[2]: *** [net/mac80211] Error 2
make[1]: *** [net] Error 2
make: *** [sub-make] Error 2


--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
