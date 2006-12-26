From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: Linux Kernel Markers format string idea
Date: Tue, 26 Dec 2006 14:48:13 -0500
Message-ID: <20061226194813.GB20627@redhat.com>
References: <20061221162035.GA9609@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <systemtap-return-5221-gls-systemtap=m.gmane.org@sourceware.org>
Content-Disposition: inline
In-Reply-To: <20061221162035.GA9609@Krystal>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, ltt-dev@shafik.org, systemtap@sources.redhat.com, linux-sparse@vger.kernel.org, michel.dagenais@polymtl.ca
List-Id: linux-sparse@vger.kernel.org

Hi -

On Thu, Dec 21, 2006 at 11:20:35AM -0500, Mathieu Desnoyers wrote:

> [...]  I just had an idea about a format string extension that would
> help fix the missing type checking with format strings for Linux
> Kernel Markers. [...]  The idea is to add the type between brackets
> after the conversion specifier.  For a pointer to a structure :
> "%p[struct mystruct *]" [...]

It's probably an improvement, though as it is still at the
programmers' discretion, it is less useful for checking and more as
documenting.  I remain ambivalent about whether exposing this level of
detail (complex typing) is a good idea, or whether imposing a small
fixed set of types (string/number/blob) is better.

- FChE
