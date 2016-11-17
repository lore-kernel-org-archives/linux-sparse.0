From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] make 'ignored_attributes[]' static
Date: Thu, 17 Nov 2016 18:18:19 +0800
Message-ID: <CANeU7Qk=a6wRtUd02dyNDetnLg4uCmOVbHAyFkouNfsz-wAeVA@mail.gmail.com>
References: <20161102171602.17833-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38221 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbcKQKSU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 05:18:20 -0500
Received: by mail-it0-f44.google.com with SMTP id j191so37298417ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 02:18:20 -0800 (PST)
In-Reply-To: <20161102171602.17833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 3, 2016 at 1:16 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> And so quiets a warning from sparse about an undeclared symbol
> when running on its own code.

Applied.

Chris
