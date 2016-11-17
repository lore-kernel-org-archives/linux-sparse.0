From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] allow to launch the test suite from the project root dir
Date: Fri, 18 Nov 2016 01:10:11 +0800
Message-ID: <CANeU7Q=OzuHLgmsJ3JH5G0+uTgj6w3k2x3-kdvduXPC9Mh_waw@mail.gmail.com>
References: <20161102232224.74747-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35482 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935463AbcKQRKM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:10:12 -0500
Received: by mail-it0-f65.google.com with SMTP id b123so16529631itb.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:10:12 -0800 (PST)
In-Reply-To: <20161102232224.74747-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 3, 2016 at 7:22 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The test suite must be run from the validation/ dir
> which is sometimes slightly annoying.
>
> Change that by letting the script to first do a cd to
> the validation dir.

Applied.

Chris
