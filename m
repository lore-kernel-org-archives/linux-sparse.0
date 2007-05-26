From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: pointer arithmetics and casts
Date: Sat, 26 May 2007 05:22:19 +0100
Message-ID: <20070526042219.GR4095@ftp.linux.org.uk>
References: <20070525212300.GL4095@ftp.linux.org.uk> <20070526034409.GO2547@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38221 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbXEZEWU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 May 2007 00:22:20 -0400
Content-Disposition: inline
In-Reply-To: <20070526034409.GO2547@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: linux-sparse@vger.kernel.org

On Sat, May 26, 2007 at 12:44:09PM +0900, Neil Booth wrote:
 
> Perhaps not overloading the "+" node; reserve that for arithmetic types.
> Have a ptr_add, (maybe) ptr_sub, and ptr_diff operations.

Making the scaling a part of operation?  It means interesting logics
at later stages, though...
