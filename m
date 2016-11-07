From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Mon, 7 Nov 2016 11:00:37 +0100
Message-ID: <20161107100036.GA443@macbook.home>
References: <20160613094517.GA25301@mwanda>
 <20161102124844.GA12544@macbook.home>
 <CANeU7Qk=Ta+QumF8BhSES9jTLDx+cdvvS8hfMQXg+B2H3Vfc-g@mail.gmail.com>
 <20161102152309.GA13632@macpro.local>
 <20161104104419.GA15485@macbook.local>
 <CANeU7QmO-7C+6JwxQDCaLotx0MZ=-HSgTc2thO8fSvxD5JR32Q@mail.gmail.com>
 <20161106084937.GA818@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38878 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbcKGKAl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Nov 2016 05:00:41 -0500
Received: by mail-wm0-f41.google.com with SMTP id f82so107415822wmf.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Nov 2016 02:00:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161106084937.GA818@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 06, 2016 at 09:49:38AM +0100, Luc Van Oostenryck wrote:
> On Sat, Nov 05, 2016 at 08:30:31AM +0800, Christopher Li wrote:
> > Those function originally all assume the list
> > are packed.
> > 
> > Is there usage case in current sparse that
> > feed unpacked list to those function?
> > 
> > Chris

OK, I've checked this on a more substantial amount of code
than the testsuite: the kernel for x86-64 with allyesconfig
and I confirm that there is not a single out-of-bounds access
to any ->list[], wich is what matters.

Nevertheless, there are two cases  (in cse.c and evaluate.c)
where elements are deleted from a list which is not directly
repacked at the end of the loop and it's not obvious in the code
why it's OK to not repack them.

Luc
