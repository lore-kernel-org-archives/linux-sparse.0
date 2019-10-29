From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: detecting misuse of of_get_property
Date: Tue, 29 Oct 2019 12:43:24 +0100
Message-ID: <e255d01b-ecd7-8386-e99e-b3226dac27c4@rasmusvillemoes.dk>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191029104917.GI1944@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191029104917.GI1944@kadam>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dan Carpenter <dan.carpenter@oracle.co>, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On 29/10/2019 11.50, Dan Carpenter wrote:
> This should probably work?

I haven't tested it, but yes, something like that. Can you also do the
case of struct property::value, i.e. handling

  struct property *p = ...;
  u32 *v = p->value;

Thanks,
Rasmus
