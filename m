From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Thu, 17 Nov 2016 06:46:44 +0800
Message-ID: <CANeU7QnyiJi3qGF9Wvz1BK6wUrEBehb94gc2JbsFkF=-d=NFVQ@mail.gmail.com>
References: <20160613094517.GA25301@mwanda> <20161102124844.GA12544@macbook.home>
 <CANeU7Qk=Ta+QumF8BhSES9jTLDx+cdvvS8hfMQXg+B2H3Vfc-g@mail.gmail.com>
 <20161102152309.GA13632@macpro.local> <20161104104419.GA15485@macbook.local>
 <CANeU7QmO-7C+6JwxQDCaLotx0MZ=-HSgTc2thO8fSvxD5JR32Q@mail.gmail.com>
 <20161106084937.GA818@macpro.local> <20161107100036.GA443@macbook.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35728 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424210AbcKPWqq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Nov 2016 17:46:46 -0500
Received: by mail-it0-f65.google.com with SMTP id b123so10492472itb.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Nov 2016 14:46:46 -0800 (PST)
In-Reply-To: <20161107100036.GA443@macbook.home>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 7, 2016 at 6:00 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> OK, I've checked this on a more substantial amount of code
> than the testsuite: the kernel for x86-64 with allyesconfig
> and I confirm that there is not a single out-of-bounds access
> to any ->list[], wich is what matters.
>
> Nevertheless, there are two cases  (in cse.c and evaluate.c)
> where elements are deleted from a list which is not directly
> repacked at the end of the loop and it's not obvious in the code
> why it's OK to not repack them.

Thanks for the extensive testing. As for the repacking, I think its
better to repack the list to after the delete of the entry. However,
we don't want to repack the list if there is not deletion at all.

How about this, we can introduce a bit field on "struct ptr_list" to
keep track of the list needs repack or not. On deletion the ptr_list will
be dirty. The other function which assuming the packed list will
check the dirty bit and complain if list is not packed.

We can even make keep the "struct ptr_list" the same size.
Just squeeze some bits from "int nr". However, that will break the
binary interface of sparse as a library. The application link with
sparse will need to be recompiled.

Chris
