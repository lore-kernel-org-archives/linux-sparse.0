From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: fun with declarations and definitions
Date: Tue, 3 Feb 2009 04:41:56 +0000
Message-ID: <20090203044156.GI28946@ZenIV.linux.org.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33058 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbZBCEl6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2009 23:41:58 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 02, 2009 at 07:07:24PM -0800, Christopher Li wrote:
> >        } else if (base_type && base_type->type == SYM_FN) {
> > +               if (decl->next_id && decl->next_id->scope == decl->scope)
> 
> Not sure what this is trying to do. Shouldn't the next line to be indented
> if I read it correctly?

Yuck.   That's a leftover that hadn't been caught since it affects only
K&R definitions.  Kill that line...

ObDeclarationParsing: I'm sorely (_very_ sorely) tempted to claim that
gcc folks are violating GPL.  Proof: gcc/c-parse.in, around productions
for declspecs_*.  Of course, they can say that this _is_ the preferred
form for making modifications, but having such admission made in public
would be worth it...  Trying to sort out the __attribute__ handling in
there just plain hurts ;-/
