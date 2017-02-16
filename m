From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/4] assorted cleanups
Date: Thu, 16 Feb 2017 10:29:47 +0800
Message-ID: <CANeU7Qnnjzn6+8UTa2hnEYPujnrO-cER-hu-wyrrpk7ODSEOQQ@mail.gmail.com>
References: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35076 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753940AbdBPC3s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 21:29:48 -0500
Received: by mail-it0-f44.google.com with SMTP id 203so85276557ith.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 18:29:48 -0800 (PST)
In-Reply-To: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 16, 2017 at 6:13 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This serie is only a small collections of independent
> cleanups, mainly removal of unused struct members.
>
> Patches 1-4 have no functional changes.
> Patch 4 make show_statement() slightly more useful.

Thanks,

Applied and pushed to sparse-next.

Do you have more patches coming? If not I am going to cut
a sparse release RC soon.

Chris
