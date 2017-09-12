From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] compile-i386.c: fix a memory leak in sort_array()
Date: Tue, 12 Sep 2017 01:26:48 -0400
Message-ID: <CANeU7QnY5yWDbw2c=UjE+tTAuKvKF99R9ECbxkri60XRkdwLQQ@mail.gmail.com>
References: <20170910120202.29853-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33425 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdILF0u (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 01:26:50 -0400
Received: by mail-yw0-f195.google.com with SMTP id q80so5367595ywg.0
        for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2017 22:26:50 -0700 (PDT)
In-Reply-To: <20170910120202.29853-1-martink@posteo.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Sep 10, 2017 at 8:02 AM, Martin Kepplinger <martink@posteo.de> wrote:
> sort_array() locally allocates a list it. Let's free it before returning
> in order to avoid memory to leak.
>
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied. While I am reading the code in that function, I notice
there is expression_list_size() which can get the size of the
expression list.

There is also a sort_list() in sort.c which can simplify sort_array().

Chris
