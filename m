From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse release v0.5.1 RC4
Date: Wed, 5 Jul 2017 14:41:33 -0700
Message-ID: <CANeU7Qnr9-8X4zcfB3z_Pe6sCWF_FdH0+K+3RWRaO=js6JyBNA@mail.gmail.com>
References: <CANeU7Q=b1PfJ7b+LzOkFRSz=vxA0VVFN6onGepgaVVHJH3z=YQ@mail.gmail.com>
 <e1c19dc8-8962-4ac8-7ee5-64fcc5f59244@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36613 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbdGEVlf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Jul 2017 17:41:35 -0400
Received: by mail-pf0-f176.google.com with SMTP id q86so802190pfl.3
        for <linux-sparse@vger.kernel.org>; Wed, 05 Jul 2017 14:41:34 -0700 (PDT)
In-Reply-To: <e1c19dc8-8962-4ac8-7ee5-64fcc5f59244@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Lance Richardson <lrichard@redhat.com>

On Wed, Jul 5, 2017 at 11:59 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 04/07/17 16:56, Christopher Li wrote:
>> RC4 has one very minor update compare to RC3.
>> Thanks to feedback from Luc, sparse now has the full list of gcc
>> attributes. It will not complain about known gcc attribute any more.
>>
>> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/
>>
>> As usual, please give it a good test. Report back any issue you might find.
>>
>> If no big surprise, I will tag the final release at the end of this week.
>
> Tested on Linux (i686 and x86_64) and cygwin (x86_64).
>
> Both the sparse testsuite and 'make sparse' on the git tree
> work as expected, without additional failures.

Thank you so much for the testing. Still looking good for the finial release
at end of this week.

Chris
