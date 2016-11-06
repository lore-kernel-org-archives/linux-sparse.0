From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Sun, 6 Nov 2016 09:49:38 +0100
Message-ID: <20161106084937.GA818@macpro.local>
References: <20160613094517.GA25301@mwanda>
 <20161102124844.GA12544@macbook.home>
 <CANeU7Qk=Ta+QumF8BhSES9jTLDx+cdvvS8hfMQXg+B2H3Vfc-g@mail.gmail.com>
 <20161102152309.GA13632@macpro.local>
 <20161104104419.GA15485@macbook.local>
 <CANeU7QmO-7C+6JwxQDCaLotx0MZ=-HSgTc2thO8fSvxD5JR32Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35948 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbcKFItm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Nov 2016 03:49:42 -0500
Received: by mail-wm0-f44.google.com with SMTP id p190so127570947wmp.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Nov 2016 01:49:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmO-7C+6JwxQDCaLotx0MZ=-HSgTc2thO8fSvxD5JR32Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Nov 05, 2016 at 08:30:31AM +0800, Christopher Li wrote:
> Those function originally all assume the list
> are packed.
> 
> Is there usage case in current sparse that
> feed unpacked list to those function?
> 
> Chris

The situation is not black & white.

There is two 'unsafe' cases.  By 'unsafe' I mean that
DELETE_CURRENT_PTR() is used but without PACK_PTR_LIST()
and the end of the iteration like done elsewhere.

OTOH, I've added at the beginning of every ptr_list loops
some assert() that check if the ptr_list is packed or not
and none ever triggered, even when LIST_NODE_NR is changed
from 29 to 1 (to force list->nr == 0 at each delete).
Also, assertions doing bound checking on ptr_list::list[]
accesses never triggered.

So, to answer your question, it seems that in the current
sparse code we don't feed unpacked lists to the 'dangerous'
functions but for the two unsafe case you can't guarantee
thsi just by looking at the local code
(or it's just by chance).

I think that for the moment, it's best to simply add
PACK_PTR_LIST() at the end of the two unsafe cases
(patch will come later).
OTOH, I feel this whole situation is a bit fragile.

NOTE: for the moment, I've only checked all this with the
testsuite. I will recheck on more substantial amount of code
but this will need to wait a little bit.


Luc
