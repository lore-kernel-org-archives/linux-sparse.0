From: Pavel Roskin <proski@gnu.org>
Subject: Re: Antwort: Re: Antwort: Re: Messing typedefs?
Date: Fri, 29 Jun 2007 19:31:55 -0400
Message-ID: <1183159915.13955.24.camel@dv>
References: <OFC8B6B106.51212EE6-ONC1257307.00233A24-C1257307.0025B204@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:51094 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXF2Xb7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 29 Jun 2007 19:31:59 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I4PwT-0001zk-OZ
	for linux-sparse@vger.kernel.org; Fri, 29 Jun 2007 19:31:57 -0400
In-Reply-To: <OFC8B6B106.51212EE6-ONC1257307.00233A24-C1257307.0025B204@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

On Wed, 2007-06-27 at 08:51 +0200, Thomas Schmid wrote:
> > My interpretation of the code is following.  Types may have idents,
> > which keep information where and how the type was defined.  Base types
> > don't have idents.
> 
> But unfortunately they get one. 

I understand it better now.  Suppose we have:

typedef struct {int a;} foo;
int main(int argc, char **argv)
{
        foo bar;
        bar.x = 1;
}

The structure is indeed unnamed.  If the error message is going to call
the _structure_ by name, it's correct to call it unnamed.

One possible fix would be to have an "inherited ident", which would be
set only by that code in external_declaration().  This would leave basic
types alone.

Then we need to come with a message that would be printed if only the
inherited ident is present.  gcc prints:

test.c:5: error: 'foo' has no member named 'x'

No "struct" is mentioned.  If we want to be more verbose, we could print
something like:

test.c:5:5: error: no member 'x' in struct type foo

Another solution would be to remove the ident setting code and try to
find the typedef name directly in evaluate_member_dereference().

-- 
Regards,
Pavel Roskin
