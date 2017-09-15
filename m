From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/8] dump the IR
Date: Fri, 15 Sep 2017 13:06:11 -0400
Message-ID: <CANeU7QnT_zeTLjfiGJnfDPbUV0AG=BFV7=QqeRg9vLdBjiOqfQ@mail.gmail.com>
References: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:48412 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdIORGN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 13:06:13 -0400
Received: by mail-yw0-f174.google.com with SMTP id v137so1808547ywg.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 10:06:12 -0700 (PDT)
In-Reply-To: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Sep 15, 2017 at 3:40 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of thsi series is to allow and control dumping of
> the IR at different stage of the processing.
>
> This is meant to be used for testing & debugging.
>
>
> Note: this series depends on the series 'option-parsing'
>
>
> This series is also available for review in the git repository at:
>
>   git://github.com/lucvoo/sparse.git dump-ir
>

I think with more extend on the dumping IR is good.

We might be able to get ride of test-linearize and test-parsing.
Just use sparse to do the dumping.

Chris
