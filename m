From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Sat, 5 Nov 2016 08:30:31 +0800
Message-ID: <CANeU7QmO-7C+6JwxQDCaLotx0MZ=-HSgTc2thO8fSvxD5JR32Q@mail.gmail.com>
References: <20160613094517.GA25301@mwanda> <20161102124844.GA12544@macbook.home>
 <CANeU7Qk=Ta+QumF8BhSES9jTLDx+cdvvS8hfMQXg+B2H3Vfc-g@mail.gmail.com>
 <20161102152309.GA13632@macpro.local> <20161104104419.GA15485@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35458 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbcKEAad (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Nov 2016 20:30:33 -0400
Received: by mail-it0-f42.google.com with SMTP id e187so12025146itc.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Nov 2016 17:30:32 -0700 (PDT)
In-Reply-To: <20161104104419.GA15485@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Those function originally all assume the list
are packed.

Is there usage case in current sparse that
feed unpacked list to those function?

Chris


On Fri, Nov 4, 2016 at 6:44 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Another thing I noticed is that after using DELETE_CURRENT_PTR()
> the next PREPARE_PTR_LIST() will fail or give wrong result if the
> list hasn't been repacked first.
>
> Maybe it's obvious but I wouldn't be surprised if there is even more
> situations that need to be protected against empty blocks.
