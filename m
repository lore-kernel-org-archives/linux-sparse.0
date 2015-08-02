From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Sun, 2 Aug 2015 19:16:54 -0400
Message-ID: <55BEA4E6.50702@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
 <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <20150730025502.GA1692@x> <55BA0E4E.7000508@redhat.com>
 <CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
 <55BCA8D2.1040808@redhat.com>
 <CANeU7QkK5N8Jskcq9J1ODCeZEQYSAJTW-6PdKg1uuZeNXPYKTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbbHBXQ4 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 2 Aug 2015 19:16:56 -0400
In-Reply-To: <CANeU7QkK5N8Jskcq9J1ODCeZEQYSAJTW-6PdKg1uuZeNXPYKTA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 08/01/2015 02:45 PM, Christopher Li wrote:
> On Sat, Aug 1, 2015 at 4:09 AM, Tony Camuso <tcamuso@redhat.com> wrote:
>>
>> I've since submitted a runtime patch (3/3 V3) with a switch as a
>> response to this patch, but it basically does the same thing here.
>>
>> Consider the case where the source contains something like this...
>>
>>          struct foo {
>>                  union {
>>                          int number;
>>                          int *pointer;
>>                  };
>>          };
>>
>> There being no ident for the union within the struct, we get the warning,
>> "missing identifier in declaration" etc.
>>
>
> I can't reproduce the warning with the chrisl repo master branch.
>
> That being said, if there is indeed a bug in sparse, it should be a
> separate patch. It changes the parsing behavior.
>
> Thanks
>
> Chris
>

This doubt this is a sparse bug. It is an most likely caused by some RHEL
specific macros with encapsulated anonymous unions devised to protect the
Kernel Application Binary Interface while backporting upstream changes
from point release to point release. I can try to convince the KABI macro
maintainers to make their macros sparse-compliant, but I'm hoping you agree
that it might not be a bad idea to provide an option to disable the sparse
error reporting in the meantime.

If you're interested in pursuing this further, these are the errors I'm
seeing, followed by the source that generates them.

/work/linux/fs/bio.i:9137:130: error: Expected ) in function declarator
/work/linux/fs/bio.i:9137:130: error: got (
builtin:0:0: error: expected ; at end of declaration
builtin:0:0: error: expected ; at end of declaration
builtin:0:0: error: expected ; at end of declaration
/work/linux/fs/bio.i:9137:172: error: Expected ; at the end of type declaration
/work/linux/fs/bio.i:9137:172: error: got }
/work/linux/fs/bio.i:9137:209: error: Expected ; at the end of type declaration
/work/linux/fs/bio.i:9137:209: error: got }
/work/linux/fs/bio.i:9137:266: error: Expected ) in function declarator
/work/linux/fs/bio.i:9137:266: error: got (
/work/linux/fs/bio.i:9137:308: error: Expected ; at the end of type declaration
/work/linux/fs/bio.i:9137:308: error: got }
/work/linux/fs/bio.i:9137:350: error: Expected ; at the end of type declaration
/work/linux/fs/bio.i:9137:350: error: got }
/work/linux/fs/bio.i:9137:382: error: Expected ; at the end of type declaration
/work/linux/fs/bio.i:9137:382: error: got }
/work/linux/fs/bio.i:9137:385: error: Expected ; at the end of type declaration
/work/linux/fs/bio.i:9137:385: error: got }
/work/linux/fs/bio.i:9139:1: error: Expected ; at the end of type declaration
/work/linux/fs/bio.i:9139:1: error: got }

The anonymous unions giving us those error messages are encapsulated
in a RHEL-specific macro.

# define _RH_KABI_REPLACE(_orig, _new)                  \
         union {                                         \
                 _new;                                   \
                 struct {                                \
                         _orig;                          \
                 } __UNIQUE_ID(rh_kabi_hide);            \
                 __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);        \
         }

Here's an example of the macro invocation.

         RH_KABI_REPLACE(void                    *spin_mlock,  /* Spinner MCS lock */
                         struct optimistic_spin_queue  *osq)   /* Spinner MCS lock */


The preprocessor expands it as follows.

  union { struct optimistic_spin_queue *osq; struct { void *spin_mlock; } __UNIQUE_ID_rh_kabi_hide0; union { _Static_assert(sizeof(struct{struct optimistic_spin_queue *osq;}) <= sizeof(struct{void *   spin_mlock;}), "kabi sizeof test panic"); _Static_assert(__alignof__(struct{struct optimistic_spin_queue *osq;}) <= __alignof__(struct{void *spin_mlock;}), "kabi alignof test panic"); }; };


