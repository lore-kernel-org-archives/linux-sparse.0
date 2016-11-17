From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] linearize: Emit C99 declarations correctly
Date: Thu, 17 Nov 2016 17:14:00 +0800
Message-ID: <CANeU7QnkFSxs3Zph=g3tKuKYNqHiZe8w1vN5Mq7Geqy773oksg@mail.gmail.com>
References: <1462365584-20536-1-git-send-email-emily@emilymaier.net> <20161102135754.GA9029@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36525 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753053AbcKQJOB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 04:14:01 -0500
Received: by mail-it0-f65.google.com with SMTP id n68so13762420itn.3
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 01:14:01 -0800 (PST)
In-Reply-To: <20161102135754.GA9029@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Emily Maier <emily@emilymaier.net>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 2, 2016 at 9:57 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, May 04, 2016 at 08:39:43AM -0400, Emily Maier wrote:
>> Variables declared with C99 syntax inside a for statement should be
>> linearized in the loop top, rather than implicitly inside the loop body.
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Tested-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Applied.

Chris

PS. I am pretty happy now I have develop a system to catch up with large
amount of back log patches.
