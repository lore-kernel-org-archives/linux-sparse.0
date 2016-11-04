From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Fri, 4 Nov 2016 11:44:20 +0100
Message-ID: <20161104104419.GA15485@macbook.local>
References: <20160613094517.GA25301@mwanda>
 <20161102124844.GA12544@macbook.home>
 <CANeU7Qk=Ta+QumF8BhSES9jTLDx+cdvvS8hfMQXg+B2H3Vfc-g@mail.gmail.com>
 <20161102152309.GA13632@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:32886 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761450AbcKDKo2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Nov 2016 06:44:28 -0400
Received: by mail-wm0-f42.google.com with SMTP id c184so10223750wmd.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Nov 2016 03:44:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161102152309.GA13632@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Another thing I noticed is that after using DELETE_CURRENT_PTR()
the next PREPARE_PTR_LIST() will fail or give wrong result if the
list hasn't been repacked first. 

Maybe it's obvious but I wouldn't be surprised if there is even more
situations that need to be protected against empty blocks.
