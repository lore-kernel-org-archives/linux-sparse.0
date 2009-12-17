From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: cgcc and REAL_CC help
Date: Thu, 17 Dec 2009 10:42:12 +0100
Message-ID: <36ca99e90912170142p26b9b0aal1a08509d65c53047@mail.gmail.com>
References: <4B29F6C2.7040800@scarlet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:37844 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbZLQJmP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Dec 2009 04:42:15 -0500
Received: by fxm21 with SMTP id 21so1704528fxm.21
        for <linux-sparse@vger.kernel.org>; Thu, 17 Dec 2009 01:42:13 -0800 (PST)
In-Reply-To: <4B29F6C2.7040800@scarlet.be>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: rubisher <rubisher@scarlet.be>
Cc: linux-sparse@vger.kernel.org

On Thu, Dec 17, 2009 at 10:15, rubisher <rubisher@scarlet.be> wrote:
> Hello all,
>
> May be can I ask you some more help.
>
> I trying to sparse a bit grub2 code but at some moment make call a sr=
ipt
> wich failled with following error:
> genkernsyms.sh: line 23: REAL_CC=3Dgcc-4.4: command not found
>
> this shell script is:
> ### The configure script will replace these variables.
>
> : ${srcdir=3D/Sources/jso/Deb.grub2/exp-wrk1}
> : ${CC=3DREAL_CC=3Dgcc-4.4 /usr/bin/cgcc}
Try:

    export REAL_CC=3Dgcc-4.4
    : ${CC=3D/usr/bin/cgcc}

Or use eval or the $CC command below.

>
> u=3D
> grep "^#define HAVE_ASM_USCORE" config.h >/dev/null 2>&1 && u=3D"_"
>
> $CC -O0 -DGRUB_MACHINE_IEEE1275=3D1 -m32 -fno-stack-protector -Wbitwi=
se
> -Wnon-pointer-null -DGRUB_SYMBOL_GENERATOR=3D1 -E -I. -Iinclude
> -I"$srcdir/include" $* \
> =C2=A0| grep -v '^#' \
> =C2=A0| sed -n \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-e '/EXPORT_FUNC *([a-zA-Z0-9_]*)/{s/.*EXP=
ORT_FUNC
> *(\([a-zA-Z0-9_]*\)).*/'"$u"'\1 kernel/;p;}' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-e '/EXPORT_VAR *([a-zA-Z0-9_]*)/{s/.*EXPO=
RT_VAR
> *(\([a-zA-Z0-9_]*\)).*/'"$u"'\1 kernel/;p;}' \
> =C2=A0| sort -u
>
> Any idea how should I fix it?
>
> Tia,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0J.
>
> PS: I am runing a debian unstable with bash 4.0-7 dpkg as shell.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
