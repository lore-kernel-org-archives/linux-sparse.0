From: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [PATCH] The require_context attribute
Date: Tue, 1 Apr 2008 16:00:04 +0200
Message-ID: <200804011600.05302.philipp.reisner@linbit.com>
References: <200803311400.32860.philipp.reisner@linbit.com> <82faac5b0804010307k498a18d5t1d4142e7e95385e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aug.linbit.com ([212.69.162.22]:42768 "EHLO mail.linbit.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754998AbYDAOAJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Apr 2008 10:00:09 -0400
In-Reply-To: <82faac5b0804010307k498a18d5t1d4142e7e95385e0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Darren Jenkins <darrenrjenkins@gmail.com>
Cc: linux-sparse@vger.kernel.org

Am Dienstag, 1. April 2008 12:07:17 schrieb Darren Jenkins:
> G'day Philipp
>
> On Mon, Mar 31, 2008 at 11:00 PM, Philipp Reisner
>
> <philipp.reisner@linbit.com> wrote:
> >  +       ctc = &ctype->ctype;
> >  +       if (ctc)
> >  +               ad->ctx_reqs = ctc->ctx_reqs;
>
> is this right ? or am I just confused ?
>

Good day Darren,

Could you elaborate in a bit more detail your concerns regarding
these lines ?

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
