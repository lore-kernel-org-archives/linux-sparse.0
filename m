From: Christopher Li <sparse@chrisli.org>
Subject: Re: Understanding how sparse handles multiple input files
Date: Thu, 15 Jun 2017 18:00:51 -0700
Message-ID: <CANeU7QmOaY+Bd=h==K=-5+McA0eASTPgmv-uS1nCDKLFDebAyg@mail.gmail.com>
References: <CACXZuxfoXKWgxxHL7hkkp=FvU5917dZ7_A4Zd=ts9j37ZG5ikw@mail.gmail.com>
 <20170615040937.dzeiuvt5ixyv5qtq@ltop.local> <CANeU7QmgaYvvjSxojOWQ3_ddqeePb=BtoLABK0DDG1DsHhD7ow@mail.gmail.com>
 <CACXZuxdAKNVw=WiAhz_FwTE4cJPf_Bk8cpZXKw9xpSGnc3yUsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38632 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdFPBAx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 21:00:53 -0400
Received: by mail-it0-f45.google.com with SMTP id b205so5284070itg.1
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jun 2017 18:00:52 -0700 (PDT)
In-Reply-To: <CACXZuxdAKNVw=WiAhz_FwTE4cJPf_Bk8cpZXKw9xpSGnc3yUsw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 15, 2017 at 4:18 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I notice also that in test_inspect there is the following:
>
> FOR_EACH_PTR_NOTAG(filelist, file) {
> struct symbol_list *syms = sparse(file);
> expand_symbols(syms);
> concat_symbol_list(syms, &view_syms);
> } END_FOR_EACH_PTR_NOTAG(file);
>
> Therefore if the symbols are dropped when the file scope ends, what is
> supposed to happen above?

It will not impact the above code. Because syms already taken out from
the parsing. It is just the per file symbols can't be lookup any more.
Here you only care about the compile result symbol (syms). That is fine.

Some other application like ctags want to examine ALL available symbols.
It will be hard from them to reach some of the symbol after you remove them
from the lookup table. I think that is the only reason to delay the removal
of the symbol to new_file_scope() rather than end_file_scope().

If you have already got the list of symbol you are interested in.
No impact for you.

Chris
