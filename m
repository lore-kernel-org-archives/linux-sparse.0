From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Adding default for m64/m32 handle
Date: Thu, 26 Jul 2012 14:14:25 +0300
Message-ID: <20120726111425.GF4352@mwanda>
References: <20120726074554.GM4403@mwanda>
 <CANeU7Qk_V12Db0a2HD9nQEfMD-i-xE84kc1T4-H+xM2SBAMSyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:26465 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab2GZLOj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jul 2012 07:14:39 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Qk_V12Db0a2HD9nQEfMD-i-xE84kc1T4-H+xM2SBAMSyg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Jul 26, 2012 at 03:28:26AM -0700, Christopher Li wrote:
> On Thu, Jul 26, 2012 at 12:45 AM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
> > Hi Chris,
> >
> > The patch 7aa79f8401f0 "Adding default for m64/m32 handle" causes
> > a problem for variables called x86_64.
> >
> > $ echo "unsigned char x86_64;" > test.c
> > $ ./sparse test.c
> > test.c:1:15: warning: missing identifier in declaration
> > test.c:1:15: error: Expected ; at the end of type declaration
> > test.c:1:15: error: got 1
> 
> Are you suggesting we do some thing like this patch to remove the
> define of x86_64?
> Gcc does not seem to define x86_64.
> 
> Any objections?

Thanks, that works.

regards,
dan carpenter

