From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: buffer overflow check bug
Date: Mon, 18 Jun 2012 23:25:01 +0300
Message-ID: <20120618202501.GN4400@mwanda>
References: <4FDF0AA5.6080905@gmail.com>
 <20120618113037.GI4400@mwanda>
 <4FDF1610.3000100@gmail.com>
 <20120618121726.GG13539@mwanda>
 <4FDF2036.4080908@gmail.com>
 <20120618134338.GJ4400@mwanda>
 <20120618181111.GH13539@mwanda>
 <CAHGf_=rNSUKPrV5yYyJ8KWbvHO4zAPU7Du4_9HbwW-HiLVbFiw@mail.gmail.com>
 <20120618195344.GM4400@mwanda>
 <20120618200407.GA3231@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:29149 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab2FRUZN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2012 16:25:13 -0400
Content-Disposition: inline
In-Reply-To: <20120618200407.GA3231@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>, smatch@vger.kernel.org, linux-sparse@vger.kernel.org

On Mon, Jun 18, 2012 at 01:04:07PM -0700, Josh Triplett wrote:
> On Mon, Jun 18, 2012 at 10:53:44PM +0300, Dan Carpenter wrote:
> > Gar...  I have no idea.  That seems like an issue in sparse.
> > 
> > Does anyone know why MOD_NORETURN gets set for:
> > extern void my_exit(const char*, ...) __attribute__ ((__noreturn__));
> > 
> > but not for:
> > extern __attribute__ ((__noreturn__)) void my_exit(const char*, ...);
> > 
> > GCC seems to accept both formats.
> 
> I wonder if the latter gets incorrectly parsed as though the attribute
> attached to "void" rather than "my_exit"?
> 

I put a:
	printf("%d %d token = %s\n", token->pos.line, token->pos.pos, token->ident->name);
in handle_attributes() and it only prints when the attribute is at
the end.

regards,
dan carpenter

