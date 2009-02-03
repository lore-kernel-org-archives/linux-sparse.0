From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: fun with declarations and definitions
Date: Tue, 3 Feb 2009 07:28:16 +0100
Message-ID: <20090203062815.GA2099@ins.uni-bonn.de>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com> <20090203044156.GI28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:53723 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZBCGyX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Feb 2009 01:54:23 -0500
Content-Disposition: inline
In-Reply-To: <20090203044156.GI28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

Hello,

* Al Viro wrote on Tue, Feb 03, 2009 at 05:41:56AM CET:
> ObDeclarationParsing: I'm sorely (_very_ sorely) tempted to claim that
> gcc folks are violating GPL.  Proof: gcc/c-parse.in, around productions
> for declspecs_*.  Of course, they can say that this _is_ the preferred
> form for making modifications, [...]

FWIW, that has since been rewritten.  Quoting gcc/ChangeLog-2005:

| 2005-02-25  Joseph S. Myers  <joseph@codesourcery.com>
| 
|         * c-parser.c: New file.
|         * c-parse.in: Remove.
[...]

Cheers,
Ralf
