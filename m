From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/3] evaluate: warn on identical exprs on ?:
Date: Sat, 27 Aug 2011 19:46:19 -0700
Message-ID: <20110828024618.GA20823@leaf>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
 <1314484015-7694-3-git-send-email-chrisf@ijw.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59521 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab1H1Cq1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 22:46:27 -0400
Content-Disposition: inline
In-Reply-To: <1314484015-7694-3-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Forbes <chrisf@ijw.co.nz>
Cc: linux-sparse@vger.kernel.org

On Sun, Aug 28, 2011 at 10:26:55AM +1200, Chris Forbes wrote:
> Adds a warning when identical expressions are found on both the true and false branches of ?:. This is another common copy-paste error.
> 
> Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>
> ---
>  evaluate.c                                 |    8 +++++++-
>  validation/check_identical_exprs_on_cond.c |   13 +++++++++++++
>  2 files changed, 20 insertions(+), 1 deletions(-)
>  create mode 100644 validation/check_identical_exprs_on_cond.c
> 
> diff --git a/evaluate.c b/evaluate.c
> index 11de7aa..c339e63 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -898,7 +898,7 @@ static int expr_list_equiv(struct expression_list *lhs,
>  int expr_equiv(struct expression *lhs, struct expression *rhs)
>  {
>  	/* recursively determine if lhs ~ rhs. */
> -	if (!lhs ^ !rhs) return 0;
> +	if (!lhs || !rhs) return 0;

You introduced this earlier in the same patch series.  This looks like
it needs some patch cleanup.

- Josh Triplett
