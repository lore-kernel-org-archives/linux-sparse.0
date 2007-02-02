From: Pavel Roskin <proski@gnu.org>
Subject: Feature request - allow boolean operations of undefined cpp symbols
Date: Fri, 02 Feb 2007 12:37:16 -0500
Message-ID: <1170437836.2272.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:60725 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945993AbXBBRhT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 12:37:19 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HD2Kd-000682-4l
	for linux-sparse@vger.kernel.org; Fri, 02 Feb 2007 12:36:15 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HD2Ld-00018t-12
	for linux-sparse@vger.kernel.org; Fri, 02 Feb 2007 12:37:17 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

I think sparse should distinguish between safe and unsafe preprocessor
operations on undefined symbols.

For instance, "#if SYMBOL" has a very specific meaning, namely in
enables the subsequent code is SYMBOL is defined and not equal 0.
Implementing this in a "sparse friendly way" would be "#if
defined(SYMBOL) && SYMBOL", which is longer and more prone to errors
(the same symbol is used once, and nobody will warn in the first
instance is mistyped).

Some projects use configuration files with entries like "#define FEATURE
1".  Some users will replace "1" with "0", some users will comment it
out.  Supporting both requires "#if FEATURE", as opposed to "#ifdef
FEATURE", or somebody will be bitterly surprised that his or her edits
had no effect.

On the other hand, "#if FOO > BAR" is highly suspicious if FOO is
undefined.  Maybe sparse could allow boolean (and only boolean)
operations on undefined cpp symbols?

Unlike Linux kernel, the cases of "#if SYMBOL" with undefined SYMBOL
exist in glibc and other system libraries.  Relaxing sparse check would
make sparse more useful for checking other software.

-- 
Regards,
Pavel Roskin
