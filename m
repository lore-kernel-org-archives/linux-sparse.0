From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: rewrite_parent_branch: Assertion `changed' failed
Date: Mon, 07 Apr 2008 21:05:49 +0200
Message-ID: <47FA708D.5080203@gmail.com>
References: <47FA6DAF.3030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:9241 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbYDGTM2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Apr 2008 15:12:28 -0400
Received: by ti-out-0910.google.com with SMTP id 28so550203tif.23
        for <linux-sparse@vger.kernel.org>; Mon, 07 Apr 2008 12:12:26 -0700 (PDT)
In-Reply-To: <47FA6DAF.3030600@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 04/07/2008 08:53 PM, Jiri Slaby wrote:
> Hi,
>=20
> I got this from sparse:
>  CHECK   /home/l/latest/xxx/net/mac80211/ieee80211.c
> sparse: flow.c:804: rewrite_parent_branch: Assertion `changed' failed=
=2E
> /bin/sh: line 1:  8639 Ne=C3=BAsp=C4=9B=C5=A1n=C4=9B ukon=C4=8Den (SI=
GABRT)        sparse=20
> -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__x86_64=
__=20
> -m64 -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.2.1/includ=
e=20
> -Wp,-MD,net/mac80211/.ieee80211.o.d -nostdinc -isystem=20
> /usr/lib64/gcc/x86_64-suse-linux/4.2.1/include -D__KERNEL__ -Iinclude=
=20
> -Iinclude2 -I/home/l/latest/xxx/include -include=20
> include/linux/autoconf.h -I/home/l/latest/xxx/net/mac80211=20
> -Inet/mac80211 -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs=20
> -fno-strict-aliasing -fno-common -Werror-implicit-function-declaratio=
n=20
> -O2 -fno-stack-protector -m64 -mtune=3Dgeneric -mno-red-zone=20
> -mcmodel=3Dkernel -funit-at-a-time -maccumulate-outgoing-args=20
> -DCONFIG_AS_CFI=3D1 -DCONFIG_AS_CFI_SIGNAL_FRAME=3D1 -pipe -Wno-sign-=
compare=20
> -fno-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2 -mno-3dno=
w=20
> -fno-omit-frame-pointer -fno-optimize-sibling-calls -g=20
> -Wdeclaration-after-statement -Wno-pointer-sign -DMODULE=20
> -D"KBUILD_STR(s)=3D#s" -D"KBUILD_BASENAME=3DKBUILD_STR(ieee80211)"=20
> -D"KBUILD_MODNAME=3DKBUILD_STR(mac80211)"=20
> /home/l/latest/xxx/net/mac80211/ieee80211.c
> make[3]: *** [net/mac80211/ieee80211.o] Error 134
> make[2]: *** [net/mac80211] Error 2
> make[1]: *** [net] Error 2
> make: *** [sub-make] Error 2

f*ck, the hand is too fast.

It's 2.6.25-rc8-mm1 code. It's opensuse sparse-0.1-46, core from the cr=
ash is here:
http://www.fi.muni.cz/~xslaby/sklad/core.sparse.bz2

It seems like anything from net/mac80211/ fail to be checked.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
