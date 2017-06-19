From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: __user with scalar data types
Date: Mon, 19 Jun 2017 17:34:38 +0100
Message-ID: <20170619163438.GE10672@ZenIV.linux.org.uk>
References: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Jun 19, 2017 at 10:15:09AM -0600, Jordan Crouse wrote:

> Which raised a bikeshed debate over whether it is appropriate to mark a scalar
> type as __user.  My opinion is that it is appropriate because __user should mark
> user memory regardless of the container.

What the hell?  __user is a qualifier like const, volatile, etc.  It's a property
of *pointer* *type*.  Not some nebulous "marks userland memory" thing.

> I'm looking for opinions or semi-authoritative edicts to determine if we should
> either start changing our uapi headers or go off and try to figure out how to
> make sparse understand this particular usage.

Stop cargo-culting, please.
