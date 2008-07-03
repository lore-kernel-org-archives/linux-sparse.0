From: Chris Lattner <clattner@apple.com>
Subject: Re: Feature request - a macro defined for GCC
Date: Thu, 3 Jul 2008 14:24:28 -0700
Message-ID: <23A4CFBC-4157-4B08-BA99-FBBCA6DDFEA4@apple.com>
References: <BLU125-W17EAD8591F0443962FC5E5A09E0@phx.gbl> <BLU125-W344BFBA01CF733DBD08F3FA09E0@phx.gbl> <486AC5A2.4070103@tuliptree.org> <BLU125-W495B0DAC339F02DDE29479A0990@phx.gbl> <486AE891.4020805@tuliptree.org> <BLU125-W23C2C0C257AF9E56E1B886A0990@phx.gbl> <486CF7C9.60001@tuliptree.org> <49C57313-8636-400D-8121-1EE7B78CAB26@apple.com> <1215119546.11853.10.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <gcc-return-147738-gcc=m.gmane.org@gcc.gnu.org>
In-Reply-To: <1215119546.11853.10.camel@josh-work.beaverton.ibm.com>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Jim Wilson <wilson@tuliptree.org>, x z <hzmonte@hotmail.com>, gcc@gnu.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Jul 3, 2008, at 2:12 PM, Josh Triplett wrote:
> I'd suggest defining exactly one new preprocessor symbol, to advertise
> the support for the feature-testing mechanism.  For instance,
> __HAVE_EXTENSION_SUPPORTED__, or __FEATURE_SUPPORTED_SUPPORTED__. :)
> The rest could use syntax like you suggest above.  For instance:


Sure.  The idea was that you'd do something like:

#ifndef __FEATURE_SUPPORTED_SUPPORTED__  /* or whatever :) */
#define has_extension(x) 0
#else
#define has_extension(x) __has_extension__(x)
#endif

which allows you to use "#if has_extension(typeof)" in your code  
portably.

In fact, it would be easy to make __has_extension__ actually be a  
macro itself, allowing one to say:

#ifdef __has_extension__
...

which is even more clear.

> The only problem then becomes maintaining the canonical list of
> extension names.  We could use the ugly approach of names like
> "org.gnu.gcc.extension.sentinel" and  
> "org.kernel.sparse.address_space",
> but that seems entirely too ugly.  The other alternative seems like a
> central registry of extension names; I'd happily help maintain such a
> registry.

I have no opinion on an approach, but I agree that it would be good to  
have a centralized list.  I would definitely add support for this to  
Clang.

-Chris
