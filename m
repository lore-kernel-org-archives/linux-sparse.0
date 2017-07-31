From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 0/7] fixes for rare issues
Date: Mon, 31 Jul 2017 17:01:35 -0400
Message-ID: <CANeU7Qk4cRLtKmPxSVCEe9WJLEb8VajdCiokNV=ic4YALvKcqw@mail.gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33455 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdGaVBg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 17:01:36 -0400
Received: by mail-pg0-f45.google.com with SMTP id c14so50419268pgn.0
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 14:01:36 -0700 (PDT)
In-Reply-To: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Jul 31, 2017 at 4:36 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series contains some fixes for crashes I found during
> some fuzzy-testing, as well as for some infinite loops
> that may happen during simplification.

Thank you so much for the patch.

I have to ask, is it for review (for now) or request to pull to
sparse-next (drop the previous version in sparse-next)?

Chris
