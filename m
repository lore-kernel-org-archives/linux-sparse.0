From: "Darren Jenkins" <darrenrjenkins@gmail.com>
Subject: Re: [PATCH] The require_context attribute
Date: Tue, 1 Apr 2008 21:07:17 +1100
Message-ID: <82faac5b0804010307k498a18d5t1d4142e7e95385e0@mail.gmail.com>
References: <200803311400.32860.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:40776 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005AbYDAKHS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Apr 2008 06:07:18 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2034123wff.4
        for <linux-sparse@vger.kernel.org>; Tue, 01 Apr 2008 03:07:17 -0700 (PDT)
In-Reply-To: <200803311400.32860.philipp.reisner@linbit.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: linux-sparse@vger.kernel.org

G'day Philipp

On Mon, Mar 31, 2008 at 11:00 PM, Philipp Reisner
<philipp.reisner@linbit.com> wrote:

>  +       ctc = &ctype->ctype;
>  +       if (ctc)
>  +               ad->ctx_reqs = ctc->ctx_reqs;


is this right ? or am I just confused ?


Darren J.
