From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Understanding how sparse handles multiple input files
Date: Fri, 16 Jun 2017 00:18:13 +0100
Message-ID: <CACXZuxdAKNVw=WiAhz_FwTE4cJPf_Bk8cpZXKw9xpSGnc3yUsw@mail.gmail.com>
References: <CACXZuxfoXKWgxxHL7hkkp=FvU5917dZ7_A4Zd=ts9j37ZG5ikw@mail.gmail.com>
 <20170615040937.dzeiuvt5ixyv5qtq@ltop.local> <CANeU7QmgaYvvjSxojOWQ3_ddqeePb=BtoLABK0DDG1DsHhD7ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38507 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdFOXSP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 19:18:15 -0400
Received: by mail-wm0-f44.google.com with SMTP id n195so10840623wmg.1
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jun 2017 16:18:15 -0700 (PDT)
In-Reply-To: <CANeU7QmgaYvvjSxojOWQ3_ddqeePb=BtoLABK0DDG1DsHhD7ow@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 15 June 2017 at 05:19, Christopher Li <sparse@chrisli.org> wrote:
>> On Wed, Jun 14, 2017 at 10:25:59PM +0100, Dibyendu Majumdar wrote:
>>> I am trying to understand what happens when multiple input files are
>>> given to sparse. Are the symbols from previous files dropped when
>>> sparse moves on to the next file?
>>>
>>> I see a call to remove_symbol_scope() in end_scope() implying that
>>> symbols are dropped - but then I am not sure I am understanding this
>>> correctly.
>
> Yes, remove_symbol_scope() just remove symbol from the hash table
> link list. After removal, the symbol will not be able to found by
> lookup_symbol()
> again.
>

I notice also that in test_inspect there is the following:

FOR_EACH_PTR_NOTAG(filelist, file) {
struct symbol_list *syms = sparse(file);
expand_symbols(syms);
concat_symbol_list(syms, &view_syms);
} END_FOR_EACH_PTR_NOTAG(file);

Therefore if the symbols are dropped when the file scope ends, what is
supposed to happen above?

Thanks and Regards
Dibyendu
