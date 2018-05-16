From: Nadav Amit <namit@vmware.com>
Subject: Re: [RFC 0/8] Improving compiler inlining decisions
Date: Wed, 16 May 2018 04:30:19 +0000
Message-ID: <03B86732-8D0B-40A7-B09C-5823104E631F@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
 <20180516034802.nuf7ft65nvtgc65j@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516034802.nuf7ft65nvtgc65j@treble>
Content-Language: en-US
Content-ID: <41EF0C5E06A1F24B953A2126074DC072@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>
List-Id: linux-sparse@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Tue, May 15, 2018 at 07:11:07AM -0700, Nadav Amit wrote:
>> This patch-set deals with an interesting yet stupid problem: code that
>> does not get inlined despite its simplicity.
>=20
> I got the 0/8 patch twice, and didn't get the 1/8 patch.  Was there an
> issue with the sending of the patches?

Strange. I am not sure why it happened. Anyhow 1/8 is available here:
https://lkml.org/lkml/2018/5/15/961 . I will forward it to you.

Thanks,
Nadav
