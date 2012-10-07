From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v2 03/10] compiler-gcc{3,4}.h: Use GCC_VERSION macro
Date: Sun, 07 Oct 2012 13:27:58 -0500
Message-ID: <5071C9AE.2010106@att.net>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com> <1349466169-20637-3-git-send-email-daniel.santos@pobox.com> <20121006231041.GB3278@liondog.tnic>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121006231041.GB3278@liondog.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org

On 10/06/2012 06:10 PM, Borislav Petkov wrote:
> On Fri, Oct 05, 2012 at 02:42:42PM -0500, danielfsantos@att.net wrote=
:
>> Using GCC_VERSION reduces complexity, is easier to read and is GCC's
>> recommended mechanism for doing version checks. (Just don't ask me w=
hy
>> they didn't define it in the first place.)  This also makes it easy =
to
>> merge compiler-gcc{,3,4}.h should somebody want to.
>>
>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
>> Acked-by: David Rientjes <rientjes@google.com>
>> ---
>
> [ =E2=80=A6 ]
>
>> diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-=
gcc4.h
>> index 4506d65..bbfeb13 100644
>> --- a/include/linux/compiler-gcc4.h
>> +++ b/include/linux/compiler-gcc4.h
>> @@ -4,7 +4,7 @@
>> =20
>>  /* GCC 4.1.[01] miscompiles __weak */
>>  #ifdef __KERNEL__
>> -# if __GNUC_MINOR__ =3D=3D 1 && __GNUC_PATCHLEVEL__ <=3D 1
>> +# if GCC_VERSION >=3D 40100 &&  GCC_VERSION <=3D 40101
>>  //#  error Your version of gcc miscompiles the __weak directive
>
> Did I miss something again? This "error" preprocessor function is
> commented out here? Why?
We'll have to ask Andrew.  Maybe so he can test on those versions of gc=
c?

commit d3ffe64a1dbcfe18b57f90f7c01c40c93d0a8b92
Author: Andrew Morton <akpm@linux-foundation.org>
Date:   Fri Sep 28 00:02:42 2012 +0000

    a
  =20
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc=
4.h
index 934bc34..997fd8a 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -5,7 +5,7 @@
 /* GCC 4.1.[01] miscompiles __weak */
 #ifdef __KERNEL__
 # if __GNUC_MINOR__ =3D=3D 1 && __GNUC_PATCHLEVEL__ <=3D 1
-#  error Your version of gcc miscompiles the __weak directive
+//#  error Your version of gcc miscompiles the __weak directive
 # endif
 #endif


I can provide you a version of these patches rebased against Linus if
you like, which I am using to test since the -mm & -next trees aren't
working on my machine (hardware, .config and/or LVM/RAID setup). I
haven't put Walken's patches underneath them however.
