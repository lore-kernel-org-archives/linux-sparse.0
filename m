From: Pavel Roskin <proski@gnu.org>
Subject: Finding all typedefs
Date: Fri, 27 Jul 2007 18:08:31 -0400
Message-ID: <1185574111.2029.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:51845 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763634AbXG0WId (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jul 2007 18:08:33 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IEY0x-00010z-Ra
	for linux-sparse@vger.kernel.org; Fri, 27 Jul 2007 18:10:27 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IEXz5-0001SE-IL
	for linux-sparse@vger.kernel.org; Fri, 27 Jul 2007 18:08:31 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

I'm trying to write a wrapper around GNU indent to make the output
result satisfy checkpatch.pl.  Unfortunately, GNU indent is bad at
recognizing types if they are just bare words defined by typedef.  Such
types should be supplied using the "-T" option to indent.

I would prefer to rely on sparse for finding all typedefs, since it's
better at parsing C code than any script I could write.

Is there any way to make sparse dump all type names declared with a
typedef?  I don't see any of the programs in sparse sources do anything
like that.  I think c2xml could be a good candidate, as it outputs the
symbol, but it doesn't give any indication that it's a typedef-defined
type:

$ make C=2 CHECK=/home/proski/src/sparse/c2xml |grep foo_t
  <symbol type="node" id="_29" ident="foo_t"
file="/home/proski/src/at76/at76_usb.c" start-line="41" start-col="13"
end-line="41" end-col="18" bit-size="32" alignment="4" offset="0"
base-type-builtin="int"/>

Another nice thing would be to have a list of labels.  Although they are
easier to find by scripts, I would prefer to find them in the same run.

-- 
Regards,
Pavel Roskin
