From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Remove unneeded variable in integer_promotion()
Date: Fri, 18 Nov 2016 00:56:05 +0800
Message-ID: <CANeU7QnAndq6D4XcvKbp5fV5-P-A0pKL7WWtUmc04+Taxb3paQ@mail.gmail.com>
References: <20161102221113.37124-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:38397 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbcKQRCT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:02:19 -0500
Received: by mail-it0-f53.google.com with SMTP id j191so62774803ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:02:19 -0800 (PST)
In-Reply-To: <20161102221113.37124-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 3, 2016 at 6:11 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Following some previous simplification done on the function,
> the variable 'orig_type' is now always the same as 'type'.
>
> To avoid possible confusion, only use 'type' and remove
> the declaration of 'orig_type'.

Indeed. Applied.

Chris
