From: "Darren Jenkins" <darrenrjenkins@gmail.com>
Subject: Re: [PATCH] The require_context attribute
Date: Wed, 2 Apr 2008 19:13:40 +1100
Message-ID: <82faac5b0804020113j762da44bjff07f8f529e802fb@mail.gmail.com>
References: <200803311400.32860.philipp.reisner@linbit.com>
	 <82faac5b0804010307k498a18d5t1d4142e7e95385e0@mail.gmail.com>
	 <200804011600.05302.philipp.reisner@linbit.com>
	 <e51f66da0804010710x13711acdy8862b5632db94012@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:44653 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYDBINk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Apr 2008 04:13:40 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2504121wff.4
        for <linux-sparse@vger.kernel.org>; Wed, 02 Apr 2008 01:13:40 -0700 (PDT)
In-Reply-To: <e51f66da0804010710x13711acdy8862b5632db94012@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Marko Kreen <markokr@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

On Wed, Apr 2, 2008 at 1:10 AM, Marko Kreen <markokr@gmail.com> wrote:

>
>  You take an address, how can it be NULL?
>

Yep, this could only happen if both the pointer was NULL and ctype was
the first structure member of struct symbol.
However neither of these things are true here.
