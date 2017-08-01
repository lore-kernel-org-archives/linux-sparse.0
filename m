From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Tue, 1 Aug 2017 17:09:12 -0400
Message-ID: <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
References: <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
 <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com> <20170801203357.4ywboptvr6tlytab@ltop.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="94eb2c13eaa63ad17e0555b78f66"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34586 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbdHAVJO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 1 Aug 2017 17:09:14 -0400
Received: by mail-pg0-f45.google.com with SMTP id u185so12642895pgb.1
        for <linux-sparse@vger.kernel.org>; Tue, 01 Aug 2017 14:09:14 -0700 (PDT)
In-Reply-To: <20170801203357.4ywboptvr6tlytab@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

--94eb2c13eaa63ad17e0555b78f66
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 1, 2017 at 4:33 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> When I try the command you gave with -rc4 sparse I get:
>         real    0m3.281s
>         user    0m3.175s
>         sys     0m0.097s
> wich is very far from the 23-30s you got. Dunno what the difference could be.

Did you run it with all the parameter?

If I just run the sort version:

time sparse -m64 -c -o usp10.o usp10.c -I. -I../../../include
-D__WINESRC__ -D_REENTRANT

It is:
real 0m4.532s
user 0m4.436s
sys 0m0.075s

But if I run with all parameter.

sh -x slow.sh

+ sparse -m64 -c -o usp10.o usp10.c -I. -I../../../include
-D__WINESRC__ -D_REENTRANT -fPIC -Wall -pipe -fno-strict-aliasing
-Wdeclaration-after-statement -Wempty-body -Wignored-qualifiers
-Wshift-overflow=2 -Wstrict-prototypes -Wtype-limits
-Wunused-but-set-parameter -Wvla -Wwrite-strings -Wpointer-arith
-Wlogical-op -gdwarf-2 -gstrict-dwarf -g -O2
/usr/include/sys/sysmacros.h:79:1: warning: constant
0xfffff00000000000u is so big it is unsigned long
/usr/include/sys/sysmacros.h:80:1: warning: constant
0x00000ffffff00000u is so big it is unsigned long
...

real 0m24.771s
user 0m24.447s
sys 0m0.213s

Again, I haven't dig very deep with this yet. Might be a bug some where indeed.

Chris

--94eb2c13eaa63ad17e0555b78f66
Content-Type: application/x-sh; name="slow.sh"
Content-Disposition: attachment; filename="slow.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j5u2pkp40

dGltZSBzcGFyc2UgLW02NCAtYyAtbyB1c3AxMC5vIHVzcDEwLmMgLUkuIC1JLi4vLi4vLi4vaW5j
bHVkZSAtRF9fV0lORVNSQ19fIC1EX1JFRU5UUkFOVCAtZlBJQyAtV2FsbCAtcGlwZSAtZm5vLXN0
cmljdC1hbGlhc2luZyAtV2RlY2xhcmF0aW9uLWFmdGVyLXN0YXRlbWVudCAtV2VtcHR5LWJvZHkg
LVdpZ25vcmVkLXF1YWxpZmllcnMgLVdzaGlmdC1vdmVyZmxvdz0yIC1Xc3RyaWN0LXByb3RvdHlw
ZXMgLVd0eXBlLWxpbWl0cyAtV3VudXNlZC1idXQtc2V0LXBhcmFtZXRlciAtV3ZsYSAtV3dyaXRl
LXN0cmluZ3MgLVdwb2ludGVyLWFyaXRoIC1XbG9naWNhbC1vcCAtZ2R3YXJmLTIgLWdzdHJpY3Qt
ZHdhcmYgLWcgLU8yCg==
--94eb2c13eaa63ad17e0555b78f66--
