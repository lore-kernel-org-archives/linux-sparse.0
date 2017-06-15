From: Christopher Li <sparse@chrisli.org>
Subject: Re: Understanding how sparse handles multiple input files
Date: Wed, 14 Jun 2017 21:19:34 -0700
Message-ID: <CANeU7QmgaYvvjSxojOWQ3_ddqeePb=BtoLABK0DDG1DsHhD7ow@mail.gmail.com>
References: <CACXZuxfoXKWgxxHL7hkkp=FvU5917dZ7_A4Zd=ts9j37ZG5ikw@mail.gmail.com>
 <20170615040937.dzeiuvt5ixyv5qtq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35396 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdFOETf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 00:19:35 -0400
Received: by mail-io0-f178.google.com with SMTP id k93so4194587ioi.2
        for <linux-sparse@vger.kernel.org>; Wed, 14 Jun 2017 21:19:35 -0700 (PDT)
In-Reply-To: <20170615040937.dzeiuvt5ixyv5qtq@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jun 14, 2017 at 9:09 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Jun 14, 2017 at 10:25:59PM +0100, Dibyendu Majumdar wrote:
>> Hi,
>>
>> I am trying to understand what happens when multiple input files are
>> given to sparse. Are the symbols from previous files dropped when
>> sparse moves on to the next file?
>>
>> I see a call to remove_symbol_scope() in end_scope() implying that
>> symbols are dropped - but then I am not sure I am understanding this
>> correctly.

Yes, remove_symbol_scope() just remove symbol from the hash table
link list. After removal, the symbol will not be able to found by
lookup_symbol()
again.

>
> I never yet looked what's happening exactly but I also had seen
> a problem when using multiple files, at least a difference
> between sparse & gcc. The difference can quickly be seen
> with an input file like:
>         int a = 1;
>         int foo(void) {}
> and then call sparse or gcc with twice the same file, like
> 'sparse $file.c $file.c' or 'gcc -c $file.c $file.c'.
>
> gcc seems to process the files independently and it will simply
> overwrite the first $file.o when processing the second one and
> this without giving a warning about 'a' or 'foo()' being redefined.
>
> sparse seems to process the files more as if being concatenated
> (even if the file scope is respected) or like it would use
> a "super-scope" above the file scope of the input files and
> will complain that 'a' and 'foo()' are redefined.

The problem you are seeing is that, sparse remove the file
scope symbols. It does not remove extern symbols. It does have
a difference compare to gcc. I think the effect is that, currently
sparse does not have a linker, if you give more than one file to
sparse. Those file will be as if they are link together (more or less).

Chris
