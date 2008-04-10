From: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 23:21:31 +0200
Message-ID: <200804102321.31681.philipp.reisner@linbit.com>
References: <20080410132519.049821000@sipsolutions.net> <200804101805.31854.philipp.reisner@linbit.com> <1207843925.13354.20.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aug.linbit.com ([212.69.162.22]:44407 "EHLO mail.linbit.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756672AbYDJVVe (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 17:21:34 -0400
In-Reply-To: <1207843925.13354.20.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

> >
> > int foo __attribute__((require_context(bar,1,99999,"rdwr")))
>
> Ah. Makes sense as well, though now you can't do something like "require
> context count two and decrement by one", can you? Or do you just do that
> by combining the various attributes?

Right, by combining a context and a require_context attribute.

>
> Anyhow, I don't really care which patch gets chosen.
>

Nor do I really care. I just hope that there is some reaction from Josh
that indicates how he wishes to continue with that toppic...
I am also ready to do further work in this area.

> Though, how can you actually track multiple contexts within a single
> function if you have just a "struct expression *context_expr" for each
> basic block? I guess I should just try your code :)
>

In the check_context() I build a expression_list of all the context 
expressions that are of interest for that entrypoint. Then check_bb_context()
is called for each of these expressions that describe a locking primitive.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
