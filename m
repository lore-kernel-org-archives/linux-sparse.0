From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] cleanup: remove unused field 'string' in struct symbol
Date: Thu, 17 Nov 2016 18:14:26 +0800
Message-ID: <CANeU7QnPbz1JgrafRHYw6GHD_jdEXPze0PVpTyiwXt1xyUVz2g@mail.gmail.com>
References: <20161102171645.17933-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34512 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbcKQKO1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 05:14:27 -0500
Received: by mail-it0-f68.google.com with SMTP id o1so14154148ito.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 02:14:27 -0800 (PST)
In-Reply-To: <20161102171645.17933-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 3, 2016 at 1:16 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This field is never used, better to remove it.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


NAK,

Some compiler back needs to generate the actual storage for the
anonymous string. Even though sparse front end is not using it now.
Another role of sparse other than checker is a C front end for other back
ends.

This is introduced at a12d4528ffc4e66b14519d739806f0eb793f72cf

    Marking anonymous string.

    The back end need to generate some storage for anonymous string.
    This simplify testing of anonymous string.

Chris
