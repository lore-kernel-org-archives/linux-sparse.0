From: rubisher <rubisher@scarlet.be>
Subject: Re: cgcc and REAL_CC help
Date: Fri, 18 Dec 2009 17:14:47 +0000
Message-ID: <4B2BB887.6060508@scarlet.be>
References: <4B29F6C2.7040800@scarlet.be> <36ca99e90912170142p26b9b0aal1a08509d65c53047@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sif.is.scarlet.be ([193.74.71.28]:48319 "EHLO sif.is.scarlet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932133AbZLRROw (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Dec 2009 12:14:52 -0500
In-Reply-To: <36ca99e90912170142p26b9b0aal1a08509d65c53047@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
Cc: linux-sparse@vger.kernel.org

Bert Wesarg wrote:
> On Thu, Dec 17, 2009 at 10:15, rubisher <rubisher@scarlet.be> wrote:
>> Hello all,
>>
>> May be can I ask you some more help.
>>
>> I trying to sparse a bit grub2 code but at some moment make call a sript
>> wich failled with following error:
>> genkernsyms.sh: line 23: REAL_CC=gcc-4.4: command not found
>>
>> this shell script is:
>> ### The configure script will replace these variables.
>>
>> : ${srcdir=/Sources/jso/Deb.grub2/exp-wrk1}
>> : ${CC=REAL_CC=gcc-4.4 /usr/bin/cgcc}
> Try:
> 
>     export REAL_CC=gcc-4.4
>     : ${CC=/usr/bin/cgcc}
> 
Tx that's egnough.

> Or use eval or the $CC command below.
> 
>> u=
>> grep "^#define HAVE_ASM_USCORE" config.h >/dev/null 2>&1 && u="_"
>>
>> $CC -O0 -DGRUB_MACHINE_IEEE1275=1 -m32 -fno-stack-protector -Wbitwise
>> -Wnon-pointer-null -DGRUB_SYMBOL_GENERATOR=1 -E -I. -Iinclude
>> -I"$srcdir/include" $* \

That said, my next issue is that "-E" which is disable by cgcc:
[snip]
     # If someone adds "-E", don't pre-process twice.
     $do_compile = 0 if $_ eq '-E';
[snip]

If ever some of you knows why, I would be interested in?

Tx again,
	J.

>>  | grep -v '^#' \
>>  | sed -n \
>>        -e '/EXPORT_FUNC *([a-zA-Z0-9_]*)/{s/.*EXPORT_FUNC
>> *(\([a-zA-Z0-9_]*\)).*/'"$u"'\1 kernel/;p;}' \
>>        -e '/EXPORT_VAR *([a-zA-Z0-9_]*)/{s/.*EXPORT_VAR
>> *(\([a-zA-Z0-9_]*\)).*/'"$u"'\1 kernel/;p;}' \
>>  | sort -u
>>
>> Any idea how should I fix it?
>>
>> Tia,
>>        J.
>>
>> PS: I am runing a debian unstable with bash 4.0-7 dpkg as shell.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

