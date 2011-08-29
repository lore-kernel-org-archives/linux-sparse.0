From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Mon, 29 Aug 2011 12:01:06 +0200
Message-ID: <20110829100106.GE15022@debian.debian>
References: <1314501260-27254-1-git-send-email-chrisf@ijw.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:36884 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751115Ab1H2KBL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 06:01:11 -0400
Content-Disposition: inline
In-Reply-To: <1314501260-27254-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Forbes <chrisf@ijw.co.nz>
Cc: linux-sparse@vger.kernel.org

On Sun, Aug 28, 2011 at 03:14:18PM +1200, Chris Forbes wrote:
> +	case EXPR_BINOP:
> +	case EXPR_COMMA:
> +	case EXPR_COMPARE:
> +	case EXPR_LOGICAL:
> +	case EXPR_ASSIGNMENT:
> +		return expr_equiv(lhs->left, rhs->left) &&
> +			expr_equiv(lhs->right, rhs->right);
[...]
> +	if ((a =3D=3D b) && (a =3D=3D b))	/* should warn */
> +		bar();
> +
> +	if ((a =3D=3D b) && (b =3D=3D c))	/* should not warn */
> +		bar();

Should it maybe also handle cases like this?

if ((a =3D=3D b) && (b =3D=3D a))
	bar();

Thanks,
	Jonathan Neusch=C3=A4fer
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
