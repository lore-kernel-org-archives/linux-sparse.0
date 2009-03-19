From: Hannes Eder <hannes@hanneseder.net>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Thu, 19 Mar 2009 19:38:51 +0100
Message-ID: <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com>
	 <20090319144622.GA28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33672 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017AbZCSSiy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 14:38:54 -0400
Received: by fxm2 with SMTP id 2so625053fxm.37
        for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2009 11:38:51 -0700 (PDT)
In-Reply-To: <20090319144622.GA28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

On Thu, Mar 19, 2009 at 3:46 PM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Thu, Mar 19, 2009 at 02:49:21PM +0100, Hannes Eder wrote:
>> running sparse (from Christopher's tree) on linux-2.6/kernel/cred.c
>> (as of next-20090318, problem may appeared earlier, I have not tried
>> yet) causes a segfault at evaluate.c:341:
>>
>> =A0 =A0 =A0 =A0 if (type->type =3D=3D SYM_NODE)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D type->ctype.base_type;
>> =A0 =A0 =A0 =A0 if (type->type =3D=3D SYM_TYPEOF) { =A0 =A0 =A0 =A0<=
=3D=3D=3D=3D=3D=3D=3D=3D SEGFAULT (type =3D=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D evaluate_expression(type->i=
nitializer);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (type->type =3D=3D SYM_NODE)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D type->ctype=
=2Ebase_type;
>> =A0 =A0 =A0 =A0 }
>>
>> the complete command line:
>>
>> sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise
>> -Wno-return-void -D__x86_64__ -m64 -nostdinc -isystem
>> /usr/lib/gcc/x86_64-redhat-linux/4.3.2/include
>> -Wp,-MD,kernel/.cred.o.d -nostdinc -isystem
>> /usr/lib/gcc/x86_64-redhat-linux/4.3.2/include -Iinclude
>> -I/home/hannes/linux-2.6/arch/x86/include -include
>> include/linux/autoconf.h -D__KERNEL__ -Wall -Wundef
>> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
>> -Werror-implicit-function-declaration -Os -m64 -mtune=3Dgeneric
>> -mno-red-zone -mcmodel=3Dkernel -funit-at-a-time
>> -maccumulate-outgoing-args -fstack-protector -fstack-protector-all
>> -DCONFIG_AS_CFI=3D1 -DCONFIG_AS_CFI_SIGNAL_FRAME=3D1 -pipe
>> -Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx
>> -mno-sse2 -mno-3dnow -fno-omit-frame-pointer
>> -fno-optimize-sibling-calls -g -pg -Wdeclaration-after-statement
>> -Wno-pointer-sign -D"KBUILD_STR(s)=3D#s"
>> -D"KBUILD_BASENAME=3DKBUILD_STR(cred)"
>> -D"KBUILD_MODNAME=3DKBUILD_STR(cred)" -D"DEBUG_HASH=3D36"
>> -D"DEBUG_HASH2=3D28" kernel/cred.c
>>
>>
>> using "git bisect" i narrowed to problem down to:
>>
>> [db31fd91f8231110ce8d8d48ce402f8cad068e44] Fix handling of ident-les=
s
>> declarations
>>
>> Does that help? Should I provide any further information?
>
> Preprocessed input would help (note that knowing the kernel tree in
> question is not enough - .config affects what comes out of preprocess=
ing,
> after all).
>
> Just slap -E in command line above and dump the output someplace publ=
ic...

I use sparse with -E <rest of the options> and gcc -E -P <rest of the
options> to produce the files
kernel-cred-c.prep.sparse and kernel-cred-c.prep.gcc, which can be foun=
d at

http://hanneseder.net/sparse/kernel-cred-c.prep.tar.gz

$ sparse kernel-cred-c.prep.gcc

produces some warnings as usual.

$ sparse kernel-cred-c.prep.sparse

produces some warnings, a boatload of errors, and then segfaults.

hth,
-Hannes
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
