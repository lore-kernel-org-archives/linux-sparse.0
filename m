From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: Sparse RFC
Date: Mon, 26 Mar 2007 17:15:23 +0100
Message-ID: <4607F19B.6080303@knosof.co.uk>
References: <1174915776.1142.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from queue02-winn.ispmail.ntl.com ([81.103.221.56]:44801 "EHLO
	queue02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752933AbXCZQib (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2007 12:38:31 -0400
In-Reply-To: <1174915776.1142.21.camel@localhost.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Darren Jenkins <darrenrjenkins@gmail.com>
Cc: Sparse mailing list <linux-sparse@vger.kernel.org>

Darren,

> I have been playing around with the sparse code, and was thinking of
> adding a few of the checks that my company uses from other code
> checkers, starting with checking that macro arguments have brackets
> around them. (Because this is the test my/other code most often fails)

This is a useful check.  However, you need to make sure that
cases where the presence of () have no impact are not flagged
if the parameter is always used in such contexts.  Otherwise the
noise can be excessive.

> 2) For the macro argument checking would it be better if I checked for
> either a bracket or low precedence operator on both sides of the
> argument ? like either a comma or a type of assignment operator? it
> would not be a foolproof check then but would seem more sensible to me,
> and might be more acceptable to users.

Don't make the assumption that everybody knows the precedence
of binary operators.  An experiment I ran last year with experienced
developers (average over 10 years) threw up some unexpected results.
See: http://www.knosof.co.uk/cbook/accu06a.pdf

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
