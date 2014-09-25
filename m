From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Make -Werror turn warnigns into errors
Date: Thu, 25 Sep 2014 10:27:43 +0800
Message-ID: <CANeU7QnkYXLGvFQbf_bER6LWa5VFcbmAn-d-guC89rNfqprecA@mail.gmail.com>
References: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
	<CANeU7QnRFxZ+OV5G2W3tC+tBnYNNcQsH_YEB=cyHmAfmfYc1PQ@mail.gmail.com>
	<20140924154207.GD4966@casper.infradead.org>
	<CANeU7QmMGAc9Y+VMhQbf9JyUBZAL5x=JGQKvMO=988S60wOwUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:61499 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaIYC1o (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 22:27:44 -0400
Received: by mail-wg0-f45.google.com with SMTP id x13so6553246wgg.4
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 19:27:43 -0700 (PDT)
In-Reply-To: <CANeU7QmMGAc9Y+VMhQbf9JyUBZAL5x=JGQKvMO=988S60wOwUg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 25, 2014 at 7:16 AM, Christopher Li <sparse@chrisli.org> wrote:

> It is just need a regular expression. In python that will be:
> r"(?m)^\S+?:\d+:\d+: error:".
> The test case is written in Perl, it will need some conversion in regular
> expression pattern.

Sorry the test case is in shell not Perl. Let me see if I can create one
using grep syntax.

Chris
