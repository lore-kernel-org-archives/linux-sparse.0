From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/7] put struct symbol & friends on diet
Date: Sat, 1 Jul 2017 14:28:44 -0700
Message-ID: <CANeU7Qnj+9d-XVbizU+sWFz==Ls6GE_zuun8z-PsaE7OLzrM6Q@mail.gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qn-+q8nDRLkLGMQUQxyLS73RC0awYN2LrCrbrE1z3+BQg@mail.gmail.com>
 <20170701083915.27ogssgsakjgjz4s@ltop.local> <CANeU7QmzA4e3ZV-8R8G+AvpNRkqxNun20-0vTFY6HH=J81y6nQ@mail.gmail.com>
 <20170701210220.36hsoiec46yf3uvw@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34849 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdGAV2q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 17:28:46 -0400
Received: by mail-pg0-f47.google.com with SMTP id j186so78284454pge.2
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 14:28:45 -0700 (PDT)
In-Reply-To: <20170701210220.36hsoiec46yf3uvw@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 1, 2017 at 2:02 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Oh, I have no reason to believe that this variance had anything
> to do with the build system. Sure kbuild have some overhead (not
> much though) but it should be as deterministic as the rest.

I should correct that I don't know how consistent is kbuild.
For me kbuild has very noticeable overhead on incremental build
compare to my script:

One job:

$ time make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CHK     scripts/mod/devicetable-offsets.h
  CHK     include/generated/compile.h
  CHK     kernel/config_data.h
  CHK     include/generated/uapi/linux/version.h
  DATAREL arch/x86/boot/compressed/vmlinux
Kernel: arch/x86/boot/bzImage is ready  (#15)
  Building modules, stage 2.
  MODPOST 6350 modules

real 2m22.493s
user 1m44.339s
sys 0m35.836s

Change that to 12 jobs:

$ time make -j12
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  DESCEND  objtool
  CHK     include/generated/utsrelease.h
  CHK     scripts/mod/devicetable-offsets.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/bounds.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CHK     kernel/config_data.h
  CHK     include/generated/uapi/linux/version.h
  Building modules, stage 2.
  LD      arch/x86/boot/compressed/vmlinux
  ZOFFSET arch/x86/boot/zoffset.h
  OBJCOPY arch/x86/boot/vmlinux.bin
  AS      arch/x86/boot/header.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  BUILD   arch/x86/boot/bzImage
Setup is 17084 bytes (padded to 17408 bytes).
System is 11508 kB
CRC 212b68e6
Kernel: arch/x86/boot/bzImage is ready  (#15)
  MODPOST 6350 modules

real 0m44.660s
user 2m10.570s
sys 0m45.502s


With my make script:

$ time make -f $PWD/linux-checker.make  -C ../linux name=master
make: Entering directory '/home/xxxx/git/kernel/linux'
make: Nothing to be done for 'all'.
make: Leaving directory '/home/xxxx/git/kernel/linux'

real 0m4.168s
user 0m4.008s
sys 0m0.143s

$ time make -j12 -f $PWD/linux-checker.make  -C ../linux name=master
make: Entering directory '/home/xxxx/git/kernel/linux'
make: Leaving directory '/home/xxxx/git/kernel/linux'

real 0m4.206s
user 0m4.106s
sys 0m0.181s


> I think it was just caused by some background tasks and I was busy
> do to stuff while measuring.

Of course back ground task will impact it.

>
> I've run a batch of time measurement on another machine really unused,
> it should give much more stable results. I'll give them when I'll have
> access to them tomorrow.

You don't have to do the test. I am fine with this change. I am just
curious with
the numbers myself.

>> I can run with some lower job count and see how it goes.
>
> No, it's OK, -j12 is as good as -j4 or -j8.
> I still found very strange that your sys time is so high.

See my other email. With lower job count, the system time
drop down a lot. If you are using kbuild, it is understandable
system time is lower, because in kbuild the make process is
doing a lot of work comparing compile parameters. That will
water down the total time required.


>> > Looking closer, calculating the mean value of each pair of measures
>> > with the standard deviation in parenthesis, then calculating the
>> > absolute and relative difference, I get:
>> >
>> >           NR = 29                  NR = 13               delta
>> > real     150.723 (1.492)         147.628 (0.653)         3.096 = 2.1%
>> > user    1095.505 (3.555)        1084.916 (1.485)        10.589 = 1.0%
>> > sys      496.098 (4.766)         470.548 (0.837)        25.550 = 5.1%
>>
>> I assume your test done with normal kernel kbuild.
>> How many run was that per setup?
>
> That's just your numbers.

Oh, Oh I see. I mis-understand that part.

Chris
