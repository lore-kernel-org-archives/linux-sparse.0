From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 09:33:10 -0700
Message-ID: <CA+55aFwQ2Yst6NqpwUbEJZ+9tcPECgp4pfgBf0HURYJByuVrCA@mail.gmail.com>
References: <nsxtxio1jeh.fsf@lambda.thunk.org>
	<20130817161718.GA18897@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20130817161718.GA18897@leaf>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Theodore Ts'o <tytso@thunk.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Sat, Aug 17, 2013 at 9:17 AM, Josh Triplett <josh@joshtriplett.org> wrote:
>
> Address space 4 is __rcu.  This warning means you accessed an RCU
> pointer directly, without using the appropriate RCU primitive
> (rcu_assign_pointer, rcu_dereference, etc).

Well, actually, in this case it was the other way around: using an RCU
primitive (rcu_assign_pointer) without having marked the variable for
RCU.

                  Linus
