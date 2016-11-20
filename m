From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/5] testsuite: report as error tests known to fail but
 which succeed
Date: Sun, 20 Nov 2016 09:43:17 +0800
Message-ID: <CANeU7Qk8J5wft5-7ePR=ZcvQPexRrv6qTOUrPOixaJVFwU1dqA@mail.gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
 <20161102214509.36571-4-luc.vanoostenryck@gmail.com> <CANeU7QnHYuW7-h+wKFcQZe=6xNUZgNdSAtLnqdAm=OBNARvR-Q@mail.gmail.com>
 <20161119004411.GA20501@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:34368 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbcKTBnT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Nov 2016 20:43:19 -0500
Received: by mail-it0-f45.google.com with SMTP id l8so11709972iti.1
        for <linux-sparse@vger.kernel.org>; Sat, 19 Nov 2016 17:43:18 -0800 (PST)
In-Reply-To: <20161119004411.GA20501@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Nov 19, 2016 at 8:44 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Like I said I prefer your version, but could you add the following patch
> on top of yours?

So you want a return code from test-suit if the test-suit does not
run as expected.

Applied and squashed.

Chris
