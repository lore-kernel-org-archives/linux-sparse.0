From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] compile-i386: make use of expression_list_size()
Date: Fri, 15 Sep 2017 10:27:47 -0400
Message-ID: <CANeU7QnHcAY=X5zZsnvTTgDbZ0sxSUAYj8zn7WUBd90G+XZF3w@mail.gmail.com>
References: <20170915070219.29239-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38838 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdIOO1s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 10:27:48 -0400
Received: by mail-yw0-f193.google.com with SMTP id t127so1771004ywg.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 07:27:48 -0700 (PDT)
In-Reply-To: <20170915070219.29239-1-martink@posteo.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Sep 15, 2017 at 3:02 AM, Martin Kepplinger <martink@posteo.de> wrote:
> Instead of doing it my hand, there is the expression_list_size() API we
> can use here.
>
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Looks good. I will apply it.

If you are feeling brave, you can try using the generic sort_list
API to sort it ;-)

Chris
