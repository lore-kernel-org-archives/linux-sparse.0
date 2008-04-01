From: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [PATCH] The require_context attribute
Date: Tue, 1 Apr 2008 16:41:03 +0200
Message-ID: <200804011641.03952.philipp.reisner@linbit.com>
References: <200803311400.32860.philipp.reisner@linbit.com> <200804011600.05302.philipp.reisner@linbit.com> <e51f66da0804010710x13711acdy8862b5632db94012@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aug.linbit.com ([212.69.162.22]:39858 "EHLO mail.linbit.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755400AbYDAOlG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Apr 2008 10:41:06 -0400
Received: from mescal.linbit (unknown [81.16.158.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3E5B42DEAC70
	for <linux-sparse@vger.kernel.org>; Tue,  1 Apr 2008 16:41:05 +0200 (CEST)
In-Reply-To: <e51f66da0804010710x13711acdy8862b5632db94012@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Am Dienstag, 1. April 2008 16:10:27 schrieb Marko Kreen:
> On 4/1/08, Philipp Reisner <philipp.reisner@linbit.com> wrote:
> > Am Dienstag, 1. April 2008 12:07:17 schrieb Darren Jenkins:
> > > G'day Philipp
> > >
> >  > On Mon, Mar 31, 2008 at 11:00 PM, Philipp Reisner
> >  >
> >  > <philipp.reisner@linbit.com> wrote:
> >  > >  +       ctc = &ctype->ctype;
> >  > >  +       if (ctc)
> >  > >  +               ad->ctx_reqs = ctc->ctx_reqs;
> >  >
> >  > is this right ? or am I just confused ?
> >
> > Good day Darren,
> >
> >  Could you elaborate in a bit more detail your concerns regarding
> >  these lines ?
>
> You take an address, how can it be NULL?

Oh, right, now I see it. Sorry. Of course that can not be NULL.

diff --git a/linearize.c b/linearize.c
index 6d401df..67c8744 100644
--- a/linearize.c
+++ b/linearize.c
@@ -888,14 +888,11 @@ static int linearize_address_gen(struct entrypoint *ep,
 	struct access_data *ad)
 {
 	struct symbol *ctype = expr->ctype;
-	struct ctype *ctc = NULL;
 
 	if (!ctype)
 		return 0;
 
-	ctc = &ctype->ctype;
-	if (ctc)
-		ad->ctx_reqs = ctc->ctx_reqs;
+	ad->ctx_reqs = ctype->ctype.ctx_reqs;
 	ad->pos = expr->pos;
 	ad->result_type = ctype;
 	ad->source_type = base_type(ctype);

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
